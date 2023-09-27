<script>
	import { page } from '$app/stores';
	import { Span, Button } from 'flowbite-svelte';

	export let data;
</script>

{#if $page.data.user?.isAdmin}
	<main class="bg-gray-100 overflow-hidden relative m-2">
		<div class="bg-white m-2">
			<h1 class="ml-2 mt-2 bg-white text-4xl font-extrabold dark:text-white p-2">User</h1>
			<hr />
			<div class="bg-white m-2 p-1">
				<div class="grid gap-6 mb-6 md:grid-cols-4 gap-6 mt-10 p-2">
					<div>
						<Span class="font-light">First Name:<Span class="m-2">{data.data.firstName}</Span></Span
						>
					</div>
					<div>
						<Span class="font-light">Last Name:<Span class="m-2">{data.data.lastName}</Span></Span>
					</div>
					<div>
						<Span class="font-light">Username:<Span class="m-2">{data.data.username}</Span></Span>
					</div>
					<div>
						<Span class="font-light">Email:<Span class="m-2">{data.data.email}</Span></Span>
					</div>
					<div>
						{#if data.data.isAdmin}
							<Span class="font-light">Administrator:<Span class="m-2">Yes</Span></Span>
						{:else}
							<Span class="font-light">Administrator:<Span class="m-2">No</Span></Span>
						{/if}
					</div>
					<div>
						<Span class="font-light">Email:<Span class="m-2">{data.data.email}</Span></Span>
					</div>
					<div>
						<Span class="font-light"
							>Department:<Span class="m-2">{data.data.department}</Span></Span
						>
					</div>
					<div>
						<Span class="font-light">Phone Home:<Span class="m-2">{data.data.phoneHome}</Span></Span
						>
					</div>
					<div>
						<Span class="font-light">Phone Work:<Span class="m-2">{data.data.phoneWork}</Span></Span
						>
					</div>
					<div>
						<Span class="font-light"
							>Phone Mobile:<Span class="m-2">{data.data.phoneMobile}</Span></Span
						>
					</div>
					<div>
						<Span class="font-light"
							>Phone Other:<Span class="m-2">{data.data.phoneOther}</Span></Span
						>
					</div>
					<div>
						<Span class="font-light">Phone Fax:<Span class="m-2">{data.data.phoneFax}</Span></Span>
					</div>
					<div>
						<Span class="font-light">Status:<Span class="m-2">{data.data.status}</Span></Span>
					</div>
					<div>
						<Span class="font-light"
							>Address Street:<Span class="m-2">{data.data.addressStreet}</Span></Span
						>
					</div>
					<div>
						<Span class="font-light"
							>Address City:<Span class="m-2">{data.data.addressCity}</Span></Span
						>
					</div>
					<div>
						<Span class="font-light"
							>Address State:<Span class="m-2">{data.data.addressState}</Span></Span
						>
					</div>
					<div>
						<Span class="font-light"
							>Address Country:<Span class="m-2">{data.data.addressCountry}</Span></Span
						>
					</div>
					<div>
						<Span class="font-light"
							>Postal Code:<Span class="m-2">{data.data.addressPostalcode}</Span></Span
						>
					</div>
					<div>
						{#if data.data.reportsToId}
							<Span class="font-light"
								>Reports To:<Span class="m-2">{data.data.reportsToId}</Span></Span
							>
						{:else}
							<Span class="font-light">Reports To:<Span class="m-2"></Span></Span>
						{/if}
					</div>
					<div>
						<Span class="font-light">2FA:<Span class="m-2">{data.data.factorAuth}</Span></Span>
					</div>
					<div>
						<Span class="font-light">Whatsapp:<Span class="m-2">{data.data.whatsapp}</Span></Span>
					</div>
					<div>
						<Span class="font-light">Telegram:<Span class="m-2">{data.data.telegram}</Span></Span>
					</div>
				</div>
				<Button href="/administration/user/edit/{data.id}">Edit</Button>
			</div>
		</div>
	</main>
{:else}
	<div>
		<h1 class="only-admin">Only admins are allowed to view this!</h1>
	</div>
{/if}

<style>
	.only-admin {
		font-size: 4em;
		margin: 4em 0;
		text-align: center;
	}
</style>
