<script>
	// @ts-nocheck

	import { Input, Label, Textarea } from 'flowbite-svelte';
</script>

<svelte:head>
	<title>Create Role</title>
</svelte:head>

<main class="bg-gray-100 overflow-hidden relative">
	<h1 class="ml-4 mt-2 bg-white text-4xl font-extrabold dark:text-white p-2 my-6">CREATE</h1>

	<div class="ml-4 mb-6">
		<Label class="space-y-2 font-medium">
			<span>Name</span>
			<Input type="text" class="w-1/7" placeholder="role name" size="sm" />
		</Label>
	</div>
	<div class="ml-4 mb-6">
		<Label for="textarea-id" class=" font-medium mb-2">Description</Label>
		<Textarea
			id="textarea-id"
			class="w-1/4"
			placeholder="description"
			rows="4"
			name="description"
		/>
	</div>
</main>
