<script>
	import { enhance } from '$app/forms';
	import { Button, Label, Search } from 'flowbite-svelte';
	import Link from './link.svelte';

	let menuOpen = false;
	let inputValue = '';
	$: console.log(inputValue);

	const menuItems = ['Partha', 'Shiv', 'Rajat', 'Alisha', 'Sophia'];
	/**
	 * @type {string | any[]}
	 */
	let filteredItems = [];

	const handleInput = () => {
		return (filteredItems = menuItems.filter((item) =>
			item.toLowerCase().match(inputValue.toLowerCase())
		));
	};
</script>

<svelte:head>
	<title>Dashboard</title>
</svelte:head>

<main class="bg-gray-100 overflow-hidden relative m-2">
	<p>Dashboard</p>
	<form action="?/#" class="bg-white m-2 p-1" use:enhance method="POST">
		<label
			for="default-search"
			class="mb-2 text-sm font-medium text-gray-900 sr-only dark:text-white">Search</label
		>
		<div class="relative w-1/6">
			<div class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none" />

			<input
				type="search"
				id="default-search"
				bind:value={inputValue}
				on:input={handleInput}
				class="block p-4 pl-10 text-sm text-gray-900 border border-gray-300 rounded-lg bg-gray-50 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
				placeholder="Search Mockups, Logos..."
			/>
			<div>
				{#if filteredItems.length > 0}
					{#each filteredItems as item}
						<Link link={item} />
					{/each}
				{:else}
					{#each menuItems as item}
						<Link link={item} />
					{/each}
				{/if}
			</div>
		</div>
	</form>
</main>

<!-- <div class="mb-6">
	<Label for="reportsToId" class="mb-2">Reports To</Label>
	<Search name="reportsToId" type="text" id="reportsToId">
		<Button>Search</Button>
	</Search>
</div> -->

<style>
	/* .dropdown {
  position: relative;
  display: inline-block;
} */

	/* .dropdown-content {
		display: none;
		position: absolute;
		background-color: #f6f6f6;
		min-width: 230px;
		border: 1px solid #ddd;
		z-index: 1;
	} */
</style>
