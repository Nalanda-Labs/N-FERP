<script>
	import { page } from '$app/stores';
	import { A } from 'flowbite-svelte';

	let list = [
		{
			heading: 'Users And Authentication',
			content1: 'User Management',
			content2: 'Role Management',
			content3: 'Password Management',
			content4: 'OAuth2 Clients and Tokens',
			content5: 'OAuth Keys',
			content6: 'Security Suite Group Management',
			content7: 'Security Suite Settings'
		}
	];
</script>

{#if $page.data.user.isAdmin}
	<main class="bg-gray-100 overflow-hidden relative m-2">
		<div class="bg-white m-2">
			<h1 class="ml-2 mt-2 bg-white text-4xl font-extrabold dark:text-white p-2">Administration</h1>
			<hr />
			<div class="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-4 gap-4 my-4 ml-2">
				{#each list as content}
					<div>
						<div class="shadow-lg px-4 py-6 bg-white relative m-2">
							<!-- {#each list as content} -->
							<p class="text-lg w-max text-gray-700 font-semibold border-b border-gray-200">
								{content.heading}
							</p>
							<div class="flex items-end space-x-2 my-6" />
							<div>
								<div
									class="flex items-center pb-2 mb-2 text-sm sm:space-x-12 justify-between border-b border-gray-200"
								>
									<A href="/administration/users">
										<p>{content.content1}</p>
									</A>
								</div>

								<div
									class="flex items-center mb-2 pb-2 text-sm space-x-12 md:space-x-24 justify-between border-b border-gray-200"
								>
									<A href="/administration/roles">
										<p>{content.content2}</p>
									</A>
								</div>
								<div
									class="lex items-center mb-2 pb-2 text-sm space-x-12 md:space-x-24 justify-between border-b border-gray-200"
								>
									<A href="/#">
										<p>{content.content3}</p>
									</A>
								</div>

								<div
									class="lex items-center mb-2 pb-2 text-sm space-x-12 md:space-x-24 justify-between border-b border-gray-200"
								>
									<A href="/#">
										<p>{content.content4}</p>
									</A>
								</div>

								<div
									class="lex items-center mb-2 pb-2 text-sm space-x-12 md:space-x-24 justify-between border-b border-gray-200"
								>
									<A href="/#">
										<p>{content.content5}</p>
									</A>
								</div>

								<div
									class="lex items-center mb-2 pb-2 text-sm space-x-12 md:space-x-24 justify-between border-b border-gray-200"
								>
									<A href="/#">
										<p>{content.content6}</p>
									</A>
								</div>

								<div
									class="lex items-center mb-2 pb-2 text-sm space-x-12 md:space-x-24 justify-between border-b border-gray-200"
								>
									<A href="/#">
										<p>{content.content7}</p>
									</A>
								</div>
							</div>
						</div>
					</div>
				{/each}
			</div>
		</div>
	</main>
{:else}
	<div>
		<h1 class="only-admin">Only admins are allowed to view this!</h1>
	</div>
{/if}

<style>
	h1.only-admin {
		margin: 4em 0;
		text-align: center;
	}

	@media (min-width: 480px) {
		h1.only-admin {
			font-size: 4em;
		}
	}
</style>
