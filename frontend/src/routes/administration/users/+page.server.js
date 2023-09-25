import { error, redirect } from '@sveltejs/kit';
import * as api from '../../../lib/api.js';

/** @type {import('./$types').PageServerLoad} */
export async function load({ locals, request, cookies }) {
	if (!locals.user) throw redirect(307, '/');

	const resp = await api.post('users', {
		sortBy: '',
		lastRecord: '',
		ascending: true
	}, cookies.get('xsrf_token'), request.headers);

	let text = await resp.text();
	let data = text ? JSON.parse(text) : {};
	if (data.errors) {
		return error(401, {message: data.errors});
	}

	return data;
}
