import jwt_decode from "jwt-decode";

/** @type {import('@sveltejs/kit').Handle} */
export function handle({ event, resolve }) {
    const jwt = event.cookies.get('logged_in');
    event.locals.user = jwt ? JSON.parse(jwt).user : null;
    console.log(event.locals.user);
    const access_token = event.cookies.get('access_token');
    event.locals.accessToken = access_token ? jwt_decode(access_token) : null;

    return resolve(event);
}