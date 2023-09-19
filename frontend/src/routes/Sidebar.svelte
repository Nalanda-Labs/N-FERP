<script>
	import { page } from '$app/stores';
	import { enhance } from '$app/forms';
	import { Sidebar, SidebarGroup, SidebarItem, SidebarWrapper } from 'flowbite-svelte';
	let spanClass = 'flex-1 ml-3 whitespace-nowrap';
	$: activeUrl = $page.url.pathname;
</script>

<Sidebar {activeUrl} class="float-left h-screen">
	<SidebarWrapper>
		<SidebarGroup>
			<SidebarItem label="Dashboard" active={activeUrl === '/dashboard'} href="/dashboard" />
			<!-- {#if $page.data.user.isAdmin} -->
			<SidebarItem label="Administration" active={activeUrl ==='/administration'} href="/administration" />
			<!-- {/if} -->
			<form use:enhance method="POST" action="/logout" style="margin-left:20px"><button type="submit">Sign Out</button></form>
		</SidebarGroup>
	</SidebarWrapper>
</Sidebar>
