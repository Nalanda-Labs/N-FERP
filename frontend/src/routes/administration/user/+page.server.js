import { fail, redirect } from '@sveltejs/kit';
import * as api from '../../../lib/api.js';

/** @type {import('./$types').PageServerLoad} */
export async function load({ locals }) {
	if (!locals.user) throw redirect(307, '/');
}

export const actions = {
	// @ts-ignore
	create: async ({ request, cookies }) => {
		let data = await request.formData();
		let isAdmin = data.get('isAdmin');

		if(isAdmin === null) {
			isAdmin = false;
		} else {
			isAdmin = true;
		}

		let factorAuth = data.get('factorAuth'); 

		if(factorAuth === null) {
			factorAuth = false;
		} else {
			factorAuth = true;
		}

		let xsrf_token = cookies.get('xsrf_token');

		const resp = await api.post('user/create', {
			firstName: data.get('firstName'),
			lastName: data.get('lastName'),
			title: data.get('title'),
			department: data.get('department'),
			email: data.get('email'),
			username: data.get('username'),
			password: data.get('password'),
			confirmPassword: data.get('confirmPassword'),
			isAdmin,
			status: data.get('status'),
			phoneHome: data.get('phoneHome'),
			phoneMobile: data.get('phoneMobile'),
			phoneWork: data.get('phoneWork'),
			phoneOther: data.get('phoneOther'),
			phoneFax: data.get('phoneFax'),
			addressStreet: data.get('addressStreet'),
			addressCity: data.get('addressCity'),
			addressState: data.get('addressState'),
			addressCountry: data.get('addressCountry'),
			addressPostalcode: data.get('addressPostalcode'),
			whatsapp: data.get('whatsapp'),
			telegram: data.get('telegram'),
			reportsToId: data.get('reportsToId'),
			employeeStatus: '',
			messengerId: '',
			messengerType: '',
			factorAuth
		}, xsrf_token, request.headers);

		let text = await resp.text();
		let j = text ? JSON.parse(text) : {};

		if (j.success === 'fail') {
			return fail(resp.status, j.errors);
		}

		throw redirect(307, `/user/${j.id}`);
	}
};
