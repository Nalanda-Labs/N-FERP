<script>
	import { page } from '$app/stores';
	import { A } from 'flowbite-svelte';
</script>

<nav class="bg-white border-gray-200 dark:bg-gray-900 border-b-2">
	<div class="max-w-full-xl flex flex-wrap items-center justify-between mx-auto p-4">
		<a href="/" class="flex items-center">
			<img src="/logo.png" class="h-8 mr-3" alt="FERP Logo" />
			<span class="self-center text-2xl font-semibold whitespace-nowrap dark:text-white">FERP</span>
		</a>
		<div class="hidden w-full md:block md:w-auto" id="navbar-default">
			<ul
				class="font-medium flex flex-col p-4 md:p-0 mt-4 border border-gray-100 rounded-lg bg-gray-50 md:flex-row md:space-x-8 md:mt-0 md:border-0 md:bg-white dark:bg-gray-800 md:dark:bg-gray-900 dark:border-gray-700"
			>
				{#if $page.data.user}
					<li>
						<A
							href="/user/{$page.data.user.username}"
							class="block py-2 pl-3 pr-4 rounded md:bg-transparent"
							aria-current="page">{$page.data.user.username}</A
						>
					</li>
				{/if}
			</ul>
		</div>
	</div>
</nav>
