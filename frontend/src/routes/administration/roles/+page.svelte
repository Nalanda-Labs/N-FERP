<script>
	// @ts-nocheck

	import {
		Table,
		TableBody,
		TableBodyCell,
		TableBodyRow,
		TableHead,
		TableHeadCell
	} from 'flowbite-svelte';
</script>

<svelte:head>
	<title>Roles</title>
</svelte:head>

<main class="bg-gray-100 h-screen overflow-hidden relative">
	<h1 class="ml-2 mt-2 bg-white text-4xl font-extrabold dark:text-white p-2">ROLES</h1>
	<div class="mt-4 mr-4 float-right">
		<a
			href="/administration/role"
			class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800"
			>New</a
		>
	</div>
	<div style="clear: both" />
	<div class="grid grid-cols-1 md:grid-cols-1 lg:grid-cols-1 bg-white my-4 ml-2">
		<div class="max-w-full overflow-x-auto rounded-lg">
			<Table striped={true}>
				<TableHead>
					<TableHeadCell>Name</TableHeadCell>
					<TableHeadCell>Description</TableHeadCell>
					<TableHeadCell>
						<span class="sr-only">Edit</span>
					</TableHeadCell>
				</TableHead>
				<TableBody class="divide-y">
					<TableBodyRow>
						<TableBodyCell>Admin</TableBodyCell>
						<TableBodyCell>He is the sys admin</TableBodyCell>
						<TableBodyCell>
							<a
								href="/tables"
								class="font-medium text-primary-600 hover:underline dark:text-primary-500">Edit</a
							>
						</TableBodyCell>
					</TableBodyRow>
					<TableBodyRow>
						<TableBodyCell>Dev</TableBodyCell>
						<TableBodyCell>He is the tech programmer</TableBodyCell>
						<TableBodyCell>
							<a
								href="/tables"
								class="font-medium text-primary-600 hover:underline dark:text-primary-500">Edit</a
							>
						</TableBodyCell>
					</TableBodyRow>
				</TableBody>
			</Table>
		</div>
	</div>
</main>
