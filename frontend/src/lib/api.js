import { error } from '@sveltejs/kit';

// change this to point it to a different host
const base = 'http://localhost:8000/api/v1';

async function send({ method, path, data, xsrf_token }) {
	const opts = { method, headers: {} };

	if (data) {
		opts.headers['Content-Type'] = 'application/json';
		opts.body = JSON.stringify(data);
	}

	if (xsrf_token) {
		opts.headers['X_XSRF-TOKEN'] = xsrf_token;
	}

	const res = await fetch(`${base}/${path}`, opts);
	if (res.ok || res.status === 422) {
		return res;
	}

	throw error(res.status);
}

export function get(path, xsrf_token) {
	return send({ method: 'GET', path, xsrf_token });
}

export function del(path, xsrf_token) {
	return send({ method: 'DELETE', path, xsrf_token });
}

export function post(path, data, xsrf_token) {
	return send({ method: 'POST', path, data, xsrf_token });
}

export function put(path, data, xsrf_token) {
	return send({ method: 'PUT', path, data, xsrf_token });
}