<script>
	import { navigating } from '$app/stores';
	import Nav from './Nav.svelte';
	import PreloadingIndicator from './PreloadingIndicator.svelte';
	import Sidebar from './Sidebar.svelte';
	import { page } from '$app/stores';
	import { redirect, fail } from '@sveltejs/kit';
	import { onMount } from 'svelte';
	import * as api from '../lib/api.js';
	import { browser } from '$app/environment';
	import '../app.css';
	import { goto } from '$app/navigation';

	onMount(async () => {
		// this immediate refresh is for the reason when user will close the
		// browser and reopen it which can lead to three cases for both
		// the access token and refresh token
		const resp = await api.get('auth/refresh', {});

		if (resp.status === 403) {
			goto('/');
		}

		const refresh = setInterval(async () => {
			if (browser) {
				const resp = await api.get('auth/refresh', {});

				if (resp.status === 403) {
					goto('/');
				}
				// TODO: remove this hardcoding
			}
		}, 10000);
		return async () => await refresh;
	});
</script>

{#if $navigating}
	<PreloadingIndicator />
{/if}

<Nav />
{#if $page.data.user}
	<Sidebar />
{/if}
<main>
	<slot />
</main>
