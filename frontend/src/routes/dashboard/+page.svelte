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
	// const setValue = (input) => {
	// 	inputValue = input;
	// };
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
				class="block p-2 border border-gray-300 rounded-lg"
				placeholder="Search Mockups, Logos..."
			/>
			<div>
				{#each filteredItems as item}
					<Link link={item} />
				{/each}
			</div>
		</div>
	</form>
</main>
