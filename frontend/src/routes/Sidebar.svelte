<script>
	import { page } from '$app/stores';
	import { enhance } from '$app/forms';
	import { Sidebar, SidebarGroup, SidebarItem, SidebarWrapper } from 'flowbite-svelte';
	import { onDestroy, onMount } from 'svelte';
	import { goto } from '$app/navigation';
	import { browser } from '$app/environment';
	import * as api from '../lib/api.js';

	let spanClass = 'flex-1 ml-3 whitespace-nowrap';
	$: activeUrl = $page.url.pathname;

	const refresh = setInterval(async () => {
		if (browser) {
			const resp = await api.get('auth/refresh', {});

			if (resp.status === 403) {
				goto('/');
			}
			// TODO: remove this hardcoding. keep this interval less than access token max age
		}
	}, 10 * 60 *1000);

	onMount(async () => {
		// this immediate refresh is for the reason when user will close the
		// browser and reopen it which can lead to three cases for both
		// the access token and refresh token
		const resp = await api.get('auth/refresh', {});

		if (resp.status === 403) {
			goto('/');
		}

		return async () => await refresh;
	});

	onDestroy(async () => {
		clearInterval(refresh);
	})
</script>

<Sidebar {activeUrl} class="float-left h-screen">
	<SidebarWrapper>
		<SidebarGroup>
			<SidebarItem label="Dashboard" active={activeUrl === '/dashboard'} href="/dashboard" />
			{#if $page.data.user && $page.data.user.isAdmin}
				<SidebarItem label="Adminstration" href="/administration" />
			{/if}
			<form use:enhance method="POST" action="/logout" style="margin-left:20px">
				<button type="submit" style="background-color: rgb(249, 250, 251)!important;color: #000">Sign Out</button>
			</form>
		</SidebarGroup>
	</SidebarWrapper>
</Sidebar>
