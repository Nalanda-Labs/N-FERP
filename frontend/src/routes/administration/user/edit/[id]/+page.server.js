import { error, redirect } from '@sveltejs/kit';
import * as api from '../../../../../lib/api.js';

/** @type {import('./$types').PageServerLoad} */
export async function load({ locals, cookies, request, params }) {
    if (!locals.user) throw redirect(307, '/');

    const resp = await api.get(`user/${params.id}`, cookies.get('xsrf_token'), request.headers);

    let text = await resp.text();
    let j = text ? JSON.parse(text) : {};

    if (j.success === 'fail') {
        throw error(401, { message: j.message });
    }

    return { data: j.data, id: params.id };
}

export const actions = {
    // @ts-ignore
    edit: async ({ request, cookies, params }) => {
        let data = await request.formData();
        let isAdmin = data.get('isAdmin');

        if (isAdmin === null) {
            isAdmin = false;
        } else {
            isAdmin = true;
        }

        let factorAuth = data.get('factorAuth');

        if (factorAuth === null) {
            factorAuth = false;
        } else {
            factorAuth = true;
        }

        let xsrf_token = cookies.get('xsrf_token');
        console.log(params.id);
        const resp = await api.post(`user/edit/${params.id}`, {
            firstName: data.get('firstName'),
            lastName: data.get('lastName'),
            title: data.get('title'),
            department: data.get('department'),
            email: data.get('email'),
            username: data.get('username'),
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
            throw error(resp.status, j.message);
        }

        throw redirect(307, `/administration/user/${j.id}`);
    }
};