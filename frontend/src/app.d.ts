// See https://kit.svelte.dev/docs/types#app
// for information about these interfaces
declare global {
	namespace App {
		// interface Error {}
		interface Locals {
			user: {
				email: String,
				username: String,
				firstName: String,
				lastName: String,
				isAdmin: Boolean
			} | null
		}
		interface PageData {
			user: {
				email: String,
				username: String,
				firstName: String,
				lastName: String,
				isAdmin: Boolean
			} | null
		}
		// interface Platform {}
	}
}

export {};
