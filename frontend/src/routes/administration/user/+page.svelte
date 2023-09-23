<script>
	import { Input, Label, Button, Select, Radio, Toggle, Checkbox } from 'flowbite-svelte';
	import { enhance } from '$app/forms';
	let selected = '';
	let roles = [
		{ value: 'admin', name: 'Administrator' },
		{ value: 'regular', name: 'Normal User' }
	];
	let selected_status = '';
	let statuses = [
		{ value: 'active', name: 'Active' },
		{ value: 'terminated', name: 'Terminated' },
		{ value: 'onLeave', name: 'On Leave' }
	];
	let selected_messanger = '';
	let messangers = [
		{ value: 'whatsapp', name: 'Whatsapp' },
		{ value: 'telegram', name: 'Telegram' }
	];
</script>

<main class="bg-gray-100 overflow-hidden relative m-2">
	<div class="bg-white m-2">
		<h1 class="ml-2 mt-2 bg-white text-4xl font-extrabold dark:text-white p-2">Add User</h1>
		<hr />
		<form action="?/create" class="bg-white m-2 p-1" use:enhance method="POST">
			<div class="grid gap-6 mb-6 md:grid-cols-4 gap-6 mt-10 p-2">
				<div>
					<Label for="firstName" class="mb-2">First name*</Label>
					<Input name="firstName" type="text" id="firstName" placeholder="John" required />
				</div>
				<div>
					<Label for="lastName" class="mb-2">Last name*</Label>
					<Input name="lastName" type="text" id="lastName" placeholder="Doe" required />
				</div>
				<div class="mb-6">
					<Label for="title" class="mb-2">Job Title</Label>
					<Input name="title" type="text" id="text" placeholder="Sales Executive" />
				</div>
				<div>
					<Label for="company" class="mb-2">Department</Label>
					<Input name="department" type="text" id="company" placeholder="Technology" />
				</div>
				<div class="mb-6">
					<Label for="email" class="mb-2">Email*</Label>
					<Input type="email" id="email" name="email" placeholder="email@domain.com" required />
				</div>
				<div class="mb-6">
					<Label for="user" class="mb-2">Username*</Label>
					<Input name="username" type="text" id="user" placeholder="john231" required />
				</div>
				<div class="mb-6">
					<Label for="password" class="mb-2">Password*</Label>
					<Input
						name="password"
						type="password"
						id="password"
						minlength="16"
						placeholder="•••••••••"
						required
					/>
				</div>
				<div class="mb-6">
					<Label for="confirmPassword" class="mb-2">Confirm Password*</Label>
					<Input
						name="confirmPassword"
						type="password"
						id="confirmPassword"
						minlength="16"
						placeholder="•••••••••"
						required
					/>
				</div>
				<div class="mb-6">
					<p class="mb-4 text-gray-900 dark:text-white">System Administrator</p>
					<Toggle name="isAdmin" />
				</div>
				<div class="mb-6">
					<Label>
						Role
						<Select class="mt-2" name="role" items={roles} bind:value={selected} />
					</Label>
				</div>
				<div class="mb-6">
					<Label>
						Status
						<Select class="mt-2" name="status" items={statuses} bind:value={selected_status} />
					</Label>
				</div>
				<div class="mb-6">
					<Label for="phoneHome" class="mb-2">Home Phone</Label>
					<Input name="phoneHome" type="tel" id="phoneHome" />
				</div>
				<div class="mb-6">
					<Label for="phoneMobile" class="mb-2">Mobile</Label>
					<Input name="phoneMobile" type="tel" id="phoneMobile" />
				</div>
				<div class="mb-6">
					<Label for="phoneWork" class="mb-2">Phone Work</Label>
					<Input name="phoneWork" type="tel" id="phoneWork" />
				</div>
				<div class="mb-6">
					<Label for="phoneOther" class="mb-2">Phone Other</Label>
					<Input name="phoneOther" type="tel" id="phoneOther" />
				</div>
				<div class="mb-6">
					<Label for="phoneFax" class="mb-2">Phone Fax</Label>
					<Input name="phoneFax" type="tel" id="phoneFax" />
				</div>
				<div class="mb-6">
					<Label for="addressStreet" class="mb-2">Address Street</Label>
					<Input name="addressStreet" type="text" id="addressStreet" />
				</div>
				<div class="mb-6">
					<Label for="addressCity" class="mb-2">City</Label>
					<Input name="addressCity" type="text" id="addressCity" />
				</div>
				<div class="mb-6">
					<Label for="addressState" class="mb-2">State</Label>
					<Input name="addressState" type="text" id="addressState" />
				</div>
				<div class="mb-6">
					<Label for="addressCountry" class="mb-2">Country</Label>
					<Input name="addressCountry" type="text" id="addressCountry" />
				</div>
				<div class="mb-6">
					<Label for="addressPostalcode" class="mb-2">Postal Code</Label>
					<Input name="addressPostalcode" type="text" id="addressPostalcode" />
				</div>
				<div class="mb-6">
					<Label for="messangerId" class="mb-2">Messanger Id</Label>
					<Input name="messangerId" type="text" id="messangerId" />
				</div>
				<div class="mb-6">
					<Label>
						Messanger
						<Select
							class="mt-2"
							name="messangerType"
							items={messangers}
							bind:value={selected_messanger}
						/>
					</Label>
				</div>
				<div class="mb-6">
					<Label for="reportsToId" class="mb-2">Reports To</Label>
					<Input name="reportsToId" type="text" id="reportsToId" />
				</div>
				<div class="mb-6">
					<Label for="factorAuth" class="mb-2">2FA</Label>
					<Toggle name="factorAuth" id="factorAuth" />
				</div>
			</div>
            <Button type="submit">Add User</Button>
		</form>
	</div>
</main>
