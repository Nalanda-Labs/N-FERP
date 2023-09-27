<script>
	// @ts-nocheck
	import {
		Input,
		Select,
		Label,
		Textarea,
		Table,
		TableBody,
		TableBodyCell,
		TableBodyRow,
		TableHead,
		TableHeadCell
	} from 'flowbite-svelte';

	let selected;
	let countries = [
		{ value: 'us', name: 'United States' },
		{ value: 'ca', name: 'Canada' },
		{ value: 'fr', name: 'France' }
	];

	let access = [
		{ value: 'enabled', name: 'Enabled' },
		{ value: 'disabled', name: 'Disabled' }
	];

	let deleted = [
		{ value: 'all', name: 'All' },
		{ value: 'group', name: 'Group' },
		{ value: 'owner', name: 'Owner' },
		{ value: 'none', name: 'None' }
	];

	let edit = [
		{ value: 'all', name: 'All' },
		{ value: 'group', name: 'Group' },
		{ value: 'owner', name: 'Owner' },
		{ value: 'none', name: 'None' }
	];

	let exports = [
		{ value: 'all', name: 'All' },
		{ value: 'group', name: 'Group' },
		{ value: 'owner', name: 'Owner' },
		{ value: 'none', name: 'None' }
	];

	let list = [
		{ value: 'all', name: 'All' },
		{ value: 'group', name: 'Group' },
		{ value: 'owner', name: 'Owner' },
		{ value: 'none', name: 'None' }
	];

	let view = [
		{ value: 'all', name: 'All' },
		{ value: 'group', name: 'Group' },
		{ value: 'owner', name: 'Owner' },
		{ value: 'none', name: 'None' }
	];

	let imported = [
		{ value: 'all', name: 'All' },
		{ value: 'none', name: 'None' }
	];

	let massUpdate = [
		{ value: 'all', name: 'All' },
		{ value: 'none', name: 'None' }
	];
</script>

<svelte:head>
	<title>Create Role</title>
</svelte:head>

<main class="bg-gray-100 overflow-hidden relative">
	<h1 class="ml-4 mt-2 bg-white text-4xl font-extrabold dark:text-white p-2 my-6">CREATE</h1>
	<div class="mr-4 float-right">
		<a
			href="/#"
			class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800"
			>Save</a
		>
	</div>
	<div class="mr-4 float-right">
		<a
			href="/#"
			class="text-white bg-blue-700 hover:bg-red-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 mr-2 mb-2 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800"
			>Delete</a
		>
	</div>

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

	<Table class="ml-4 mb-6 mt-2">
		<TableHead>
			<TableHeadCell />
			<TableHeadCell>Access</TableHeadCell>
			<TableHeadCell>Edit</TableHeadCell>
			<TableHeadCell>Delete</TableHeadCell>
			<TableHeadCell>Export</TableHeadCell>
			<TableHeadCell>Import</TableHeadCell>
			<TableHeadCell>List</TableHeadCell>
			<TableHeadCell>Mass Update</TableHeadCell>
			<TableHeadCell>View</TableHeadCell>
		</TableHead>
		<TableBody class="divide-y">
			<TableBodyRow>
				<TableBodyCell>Accounts</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Alerts</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Bugs</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Calls</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Calls reschedule</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Campaigns</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Case Events</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Case Updates</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Cases</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Contacts</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Contracts</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Documents</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>EAPM</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Email-Templates</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Email Marketing</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Emails</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Events</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>External OAuth Connection</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>External OAuth Provider</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Inbound Email Accounts</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Invoices</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>KB - Categories</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Knowledge Base</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Leads</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Maps</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>LocatMaps - Address Cache ions</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Maps - Areas</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Meetings</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Notes</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Opportunities</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Outbound Email Accounts</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>PDF - Templates</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>PDF - Templates</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Process Audit</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Products</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Products - Categories</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Project Task Templates</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Projects - Templates</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Quotes</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Reports</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Scheduled Reports</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
			<TableBodyRow>
				<TableBodyCell>Security Suite Management</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={access} bind:value={selected} placeholder="Not Set" />
					</Label>
				</TableBodyCell>
				<TableBodyCell
					><Label>
						<Select items={edit} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={deleted} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={exports} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={imported} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={list} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={massUpdate} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
				<TableBodyCell
					><Label>
						<Select items={view} bind:value={selected} placeholder="Not Set" />
					</Label></TableBodyCell
				>
			</TableBodyRow>
		</TableBody>
	</Table>
</main>
