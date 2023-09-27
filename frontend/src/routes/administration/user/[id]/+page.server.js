import { error, redirect } from '@sveltejs/kit';
import * as api from '../../../../lib/api.js';

/** @type {import('./$types').PageServerLoad} */
export async function load({ locals, cookies, request, params }) {
    if (!locals.user) throw redirect(307, '/');

    const resp = await api.get(`user/${params.id}`, cookies.get('xsrf_token'), request.headers);

    let text = await resp.text();
    let j = text ? JSON.parse(text) : {};

    if (j.success === 'fail') {
        throw error(401, { message: j.message });
    }

    console.log(j);
    return {data:j.data, id:params.id};
}