/** @type {import('./$types').LayoutServerLoad} */
export function load({ locals }) {
    return {
        user: locals.user && {
            username: locals.user.username,
            email: locals.user.email,
            first_name: locals.user.first_name,
            last_name: locals.user.last_name,
            is_admin: locals.user.is_admin
        }
    };
}