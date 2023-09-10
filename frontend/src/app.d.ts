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
			} | null,
			accessToken: {
				token: String,
				tokenUuid: String,
				userId: String,
				expiresIn: int
			} | null
		}
		interface PageData {
			user: {
				email: String,
				username: String,
				firstName: String,
				lastName: String,
				isAdmin: Boolean
			}
		}
		// interface Platform {}
	}
}

export {};
