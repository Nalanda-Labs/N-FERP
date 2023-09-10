<script>
	import { navigating } from '$app/stores';
	import Nav from './Nav.svelte';
	import PreloadingIndicator from './PreloadingIndicator.svelte';
	import Sidebar from './Sidebar.svelte';
	import { page } from '$app/stores';

	import "../app.css";
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