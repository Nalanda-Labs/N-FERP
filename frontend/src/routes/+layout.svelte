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

	onMount(async () => {
		const refresh = setInterval(async () => {
			if (browser) {
				// TODO: Implement refresh token handling
				// the time for access token is 15 min.
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
