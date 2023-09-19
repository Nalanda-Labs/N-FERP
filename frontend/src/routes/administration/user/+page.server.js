export const actions = {
	// @ts-ignore
	create: async ({ request }) => {
		const formData = await request.formData();
		console.log(formData.get('first_name'));
		return {
			success: true,
			formData
		};
	}
};


import { redirect } from '@sveltejs/kit';

/** @type {import('./$types').PageServerLoad} */
export async function load({ locals }) {
	if (!locals.user) throw redirect(307, '/');
}