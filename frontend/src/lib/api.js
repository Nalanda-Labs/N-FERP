import { error } from '@sveltejs/kit';

// change this to point it to a different host
const base = 'http://localhost/api/v1';

async function send({ method, path, data, xsrf_token, headers }) {
	const opts = { method, headers: {}, credentials: 'include' };

	if (data) {
		opts.headers['Content-Type'] = 'application/json';
		opts.body = JSON.stringify(data);
	}

	if (xsrf_token) {
		opts.headers['X-XSRF-TOKEN'] = xsrf_token;
	}

	// this is needed so that cookies are set when request originate from server
	if (headers) {
		for (const [key, value] of headers.entries()) {
			if (key === 'cookie') {
				opts.headers[key] = value;
			}
		}
	}

	// this is needed so that cookies are set when request originate from browser
	opts.credentials = 'include';

	const res = await fetch(`${base}/${path}`, opts);

	if (res.ok || res.status === 422) {
		return res;
	}

	throw error(res.status);
}

export function get(path, xsrf_token, headers) {
	return send({ method: 'GET', path, xsrf_token, headers });
}

export function del(path, xsrf_token, headers) {
	return send({ method: 'DELETE', path, xsrf_token, headers });
}

export function post(path, data, xsrf_token, headers) {
	return send({ method: 'POST', path, data, xsrf_token, headers });
}

export function put(path, data, xsrf_token, headers) {
	return send({ method: 'PUT', path, data, xsrf_token, headers });
}