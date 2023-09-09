import { fail, redirect } from '@sveltejs/kit';
import * as api from '../lib/api.js';

/** @type {import('./$types').PageServerLoad} */
export async function load({ locals }) {
	if (locals.user) throw redirect(307, '/dashboard');
}

/** @type {import('./$types').Actions} */
export const actions = {
	default: async ({ cookies, request }) => {
		const data = await request.formData();

		const resp = await api.post('auth/login', {
			email: data.get('email'),
			password: data.get('password')
		});

		let text = await resp.text();
		let j = text ? JSON.parse(text) : {};
		if (j.errors) {
			return fail(401, j);
		}

		for (const pair of resp.headers.entries()) {
			if (pair[0] === 'set-cookie') {
				let split_cookie = pair[1].split(';');
				var i = split_cookie[0].indexOf('=');
				var name = split_cookie[0].slice(0, i);
				var value = split_cookie[0].slice(i + 1);
				cookies.set(name, value);
			}
		}

		throw redirect(307, '/dashboard');
	}
};