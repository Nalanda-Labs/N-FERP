<script>
	import { page } from '$app/stores';
	import { Input, Label, Button, Select, Toggle, Search, Alert } from 'flowbite-svelte';
	import { InfoCircleSolid } from 'flowbite-svelte-icons';
	import * as api from '../../../../../lib/api.js';
	import { enhance } from '$app/forms';

	export let data;
	let statuses = [
		{ value: 'active', name: 'Active' },
		{ value: 'terminated', name: 'Terminated' },
		{ value: 'onLeave', name: 'On Leave' }
	];

	let error = '';
	let emailExists = '';

	async function checkEmail() {
		const email = document.getElementById('email')?.value;

        if (email === data.data.email) {
            return;
        }

		if (email && email.includes('@')) {
			try {
				// TODO: considering moving this xsrf_token code to a common place
				let xsrf_token = document.cookie.split('=')[1];
				let resp = await api.post('email-exists', { email }, xsrf_token);
				let data = JSON.parse(await resp.text());
				if (data.status && data.status === 'success') {
					emailExists = 'This email already exists.';
				} else {
					emailExists = '';
				}
			} catch (e) {
				console.log(e);
				error = 'An error occurred. Please contact support.';
			}
		}
	}

	let usernameExists = '';

	async function checkUsername() {
		const username = document.getElementById('username')?.value;

        if(username === data.data.username) {
            return;
        }

		try {
			// TODO: considering moving this xsrf_token code to a common places
			let xsrf_token = document.cookie.split('=')[1];
			let resp = await api.post('username-exists', { username }, xsrf_token);
			let data = JSON.parse(await resp.text());
			if (data.status && data.status === 'success') {
				usernameExists = 'This username already exists.';
			} else {
				usernameExists = '';
			}
		} catch (e) {
			error = 'An error occurred. Please contact support.';
		}
	}
</script>

{#if $page.data.user?.isAdmin}
	<main class="bg-gray-100 overflow-hidden relative m-2">
		<div class="bg-white m-2">
			<h1 class="ml-2 mt-2 bg-white text-4xl font-extrabold dark:text-white p-2">Add User</h1>
			{#if error}
				<Alert dismissable>
					<InfoCircleSolid slot="icon" class="w-4 h-4" />
					{error}
				</Alert>
			{/if}
			<hr />
			<form action="?/edit" class="bg-white m-2 p-1" use:enhance method="POST">
				<div class="grid gap-6 mb-6 md:grid-cols-4 gap-6 mt-10 p-2">
					<div>
						<Label for="firstName" class="mb-2">First name<span class="text-red-500">*</span></Label
						>
						<Input
							name="firstName"
							type="text"
							id="firstName"
							minlength="2"
							maxlength="255"
							placeholder="John"
							required
							value={data.data.firstName}
						/>
					</div>
					<div>
						<Label for="lastName" class="mb-2">Last name<span class="text-red-500">*</span></Label>
						<Input
							name="lastName"
							type="text"
							id="lastName"
							minlength="2"
							maxlength="255"
							placeholder="Doe"
							required
							value={data.data.lastName}
						/>
					</div>
					<div class="mb-6">
						<Label for="title" class="mb-2">Job Title</Label>
						<Input
							name="title"
							type="text"
							maxlength="50"
							id="text"
							placeholder="Sales Executive"
							value={data.data.title}
						/>
					</div>
					<div>
						<Label for="company" class="mb-2">Department</Label>
						<Input
							name="department"
							type="text"
							maxlength="255"
							id="company"
							placeholder="Technology"
							value={data.data.department}
						/>
					</div>
					<div class="mb-6">
						<Label for="email" class="mb-2">Email<span class="text-red-500">*</span></Label>
						<Input
							type="email"
							id="email"
							name="email"
							minlength="3"
							maxlength="256"
							placeholder="email@domain.com"
							on:input={checkEmail}
							required
							value={data.data.email}
						/>
						<span class="red text-xs text-red-700">{emailExists}</span>
					</div>
					<div class="mb-6">
						<Label for="user" class="mb-2">Username<span class="text-red-500">*</span></Label>
						<Input
							name="username"
							type="text"
							id="username"
							maxlenght="64"
							placeholder="john231"
							on:input={checkUsername}
							required
							value={data.data.username}
						/>
						<span class="red text-xs text-red-700">{usernameExists}</span>
					</div>
					<div class="mb-6">
						<Label>
							Status
							<Select class="mt-2" name="status" value={data.data.status} items={statuses} />
						</Label>
					</div>
					<div class="mb-6">
						<Label for="phoneHome" class="mb-2">Home Phone</Label>
						<Input name="phoneHome" type="tel" id="phoneHome" value={data.data.phoneHome} />
					</div>
					<div class="mb-6">
						<Label for="phoneMobile" class="mb-2">Mobile</Label>
						<Input name="phoneMobile" type="tel" id="phoneMobile" value={data.data.phoneMobile} />
					</div>
					<div class="mb-6">
						<Label for="phoneWork" class="mb-2">Phone Work</Label>
						<Input name="phoneWork" type="tel" id="phoneWork" value={data.data.phoneWork} />
					</div>
					<div class="mb-6">
						<Label for="phoneOther" class="mb-2">Phone Other</Label>
						<Input name="phoneOther" type="tel" id="phoneOther"  value={data.data.phoneOther} />
					</div>
					<div class="mb-6">
						<Label for="phoneFax" class="mb-2">Phone Fax</Label>
						<Input name="phoneFax" type="tel" id="phoneFax"  value={data.data.phonefax} />
					</div>
					<div class="mb-6">
						<Label for="addressStreet" class="mb-2">Address Street</Label>
						<Input name="addressStreet" maxlength="255" type="text" id="addressStreet"  value={data.data.addressStreet} />
					</div>
					<div class="mb-6">
						<Label for="addressCity" class="mb-2">City</Label>
						<Input name="addressCity" maxlength="100" type="text" id="addressCity"  value={data.data.addressCity} />
					</div>
					<div class="mb-6">
						<Label for="addressState" class="mb-2">State</Label>
						<Input name="addressState" maxlength="100" type="text" id="addressState"  value={data.data.addressState} />
					</div>
					<div class="mb-6">
						<Label for="addressCountry" class="mb-2">Country</Label>
						<Input name="addressCountry" maxlength="100" type="text" id="addressCountry"  value={data.data.addressCountry} />
					</div>
					<div class="mb-6">
						<Label for="addressPostalcode" class="mb-2">Postal Code</Label>
						<Input name="addressPostalcode" maxlength="20" type="text" id="addressPostalcode"  value={data.data.addressPostalcode} />
					</div>
					<div class="mb-6">
						<Label for="whatsapp" class="mb-2">Whatsapp No.</Label>
						<Input name="whatsapp" type="tel" id="whatsapp"  value={data.data.whatsapp} />
					</div>
					<div class="mb-6">
						<Label for="telegram" class="mb-2">Telegram No.</Label>
						<Input name="telegram" type="tel" id="telegram"  value={data.data.telegram} />
					</div>
					<div class="mb-6">
						<Label for="reportsToId" class="mb-2">Reports To</Label>
						<Search name="reportsToId" type="text" id="reportsToId"  value={data.data.reportsToId} >
							<Button>Search</Button>
						</Search>
					</div>
					<div class="mb-6">
						<Label for="factorAuth" class="mb-2">System Administrator</Label>
                        {#if data.data.isAdmin}
						<Toggle name="isAdmin" checked />
                        {:else}
                        <Toggle name="isAdmin" />
                        {/if}
					</div>
					<div class="mb-6">
						<Label for="factorAuth" class="mb-2">2FA</Label>
                        {#if data.data.factorAuth}
						<Toggle name="factorAuth" id="factorAuth" checked/>
                        {:else}
                        <Toggle name="factorAuth" id="factorAuth"/>
                        {/if}
					</div>
				</div>
				<Button type="submit">Edit User</Button>
			</form>
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
