<script>
	import { page } from '$app/stores';
	import {
		Table,
		TableBody,
		TableBodyCell,
		TableBodyRow,
		TableHead,
		TableHeadCell,
		Button,
		A,
		Checkbox
	} from 'flowbite-svelte';
	import { readonly } from 'svelte/store';

	export let data;
</script>

<main class="bg-gray-100 overflow-hidden relative">
	<div class="bg-white m-2">
		{#if $page.data.user.isAdmin}
		<h1 class="ml-2 mt-2 bg-white text-4xl font-extrabold dark:text-white p-2">Users</h1>
		<hr />
		<div class="mt-4 mr-4 float-right">
			<Button href="/administration/user">Add</Button>
		</div>
		<div style="clear: both;" />
		<div class="grid grid-cols-1 md:grid-cols-1 lg:grid-cols-1 bg-white my-4 ml-2">
			<div class="max-w-full overflow-x-auto rounded-lg">
				<Table striped={true}>
					<TableHead>
						<TableHeadCell>First Name</TableHeadCell>
						<TableHeadCell>Last Name</TableHeadCell>
						<TableHeadCell>Username</TableHeadCell>
						<TableHeadCell>Phone Work</TableHeadCell>
						<TableHeadCell>Email</TableHeadCell>
						<TableHeadCell>Status</TableHeadCell>
						<TableHeadCell>Department</TableHeadCell>
						<TableHeadCell>Administrator</TableHeadCell>
						<TableHeadCell>
							<span class="sr-only">Edit</span>
						</TableHeadCell>
					</TableHead>
					<TableBody class="divide-y">
						{#each data.users as user}
						<TableBodyRow>
							<TableBodyCell>{user.firstName||''}</TableBodyCell>
							<TableBodyCell>{user.lastName||''}</TableBodyCell>
							<TableBodyCell>{user.username||''}</TableBodyCell>
							<TableBodyCell>{user.phoneWork||''}</TableBodyCell>
							<TableBodyCell>{user.email}</TableBodyCell>
							<TableBodyCell>{user.status||''}</TableBodyCell>
							<TableBodyCell>{user.department||''}</TableBodyCell>
							<TableBodyCell>
								{#if user.isAdmin}
								<Checkbox checked disabled></Checkbox>
								{:else}
								<Checkbox disabled></Checkbox>
								{/if}
							</TableBodyCell>
							<TableBodyCell><A href="/user/edit/{user.id}">Edit</A></TableBodyCell>
						</TableBodyRow>
						{/each}
					</TableBody>
				</Table>
			</div>
		</div>
		{:else}
		<h1 class="only-admin">Only admins are allowed to view this!</h1>
		{/if}
	</div>
</main>

<style>
	.only-admin {
		font-size: 4em;
		margin: 4em 0;
		text-align: center;
	}
</style>
