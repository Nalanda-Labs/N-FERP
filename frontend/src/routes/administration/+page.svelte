Aministration

<script>
  let list = [
    {
      heading: 'Users And Authentication',
      content1: 'User Management',
      content2: 'Role Management',
      content3: 'Password Management',
      content4: 'OAuth2 Clients and Tokens',
      content5: 'OAuth Keys',
      content6: 'Security Suite Group Management',
      content7: 'Security Suite Settings',
    },
  ];
</script>


<main class="bg-gray-100 h-screen overflow-hidden relative">
	<div class="grid grid-cols-1 md:grid-cols-3 lg:grid-cols-3 gap-4 my-4">
		<!-- <div class="w-full">
			<div class="shadow-lg px-4 py-6 w-full bg-white relative">
				<p
					class="text-sm w-max text-gray-700 font-semibold border-b border-gray-200"
				>
					Users And Authentication
				</p>
				<div class="flex items-end space-x-2 my-6">					
				</div>
				<div>
					<div
						class="flex items-center pb-2 mb-2 text-sm sm:space-x-12  justify-between border-b border-gray-200"
					>
                        <a href="/#">
                            <p>User Management</p>
                        </a>
					</div>

					<div
						class="flex items-center mb-2 pb-2 text-sm space-x-12 md:space-x-24 justify-between border-b border-gray-200"
					>
                        <a href="/#">
                            <p>Role Management</p>
                        </a>		
					</div>
					<div class="lex items-center mb-2 pb-2 text-sm space-x-12 md:space-x-24 justify-between border-b border-gray-200">
                        <a href="/#">
                            <p>Password Management</p>
                        </a>	
					</div>

                    <div class="lex items-center mb-2 pb-2 text-sm space-x-12 md:space-x-24 justify-between border-b border-gray-200">
                        <a href="/#">
                            <p>OAuth2 Clients and Tokens</p>
                        </a>
					</div>

                    <div class="lex items-center mb-2 pb-2 text-sm space-x-12 md:space-x-24 justify-between border-b border-gray-200">	
                        <a href="/#">
                            <p>OAuth Keys</p>
                        </a> 
					</div>

                    <div class="lex items-center mb-2 pb-2 text-sm space-x-12 md:space-x-24 justify-between border-b border-gray-200">	
                        <a href="/#">
                            <p>Security Suite Group Management</p>
                        </a>
					</div>

                    <div class="lex items-center mb-2 pb-2 text-sm space-x-12 md:space-x-24 justify-between border-b border-gray-200">
                        <a href="/#">
                            <p>Security Suite Settings</p>
                        </a>	
					</div>
                    

                    
				</div>
			</div>
		</div> -->
        {#each list as content}
		<div>
			<div class="shadow-lg px-4 py-6 w-full bg-white relative">
                <!-- {#each list as content} -->
				<p
					class="text-sm w-max text-gray-700 font-semibold border-b border-gray-200"
				>
					{content.heading}
				</p>
				<div class="flex items-end space-x-2 my-6">					
				</div>
				<div>
					<div
						class="flex items-center pb-2 mb-2 text-sm sm:space-x-12  justify-between border-b border-gray-200"
					>
                        <a href="/administration/users">
                            <p>{content.content1}</p>
                        </a>
					</div>

					<div
						class="flex items-center mb-2 pb-2 text-sm space-x-12 md:space-x-24 justify-between border-b border-gray-200"
					>
                        <a href="/#">
                            <p>{content.content2}</p>
                        </a>		
					</div>
					<div class="lex items-center mb-2 pb-2 text-sm space-x-12 md:space-x-24 justify-between border-b border-gray-200">
                        <a href="/#">
                            <p>{content.content3}</p>
                        </a>	
					</div>

                    <div class="lex items-center mb-2 pb-2 text-sm space-x-12 md:space-x-24 justify-between border-b border-gray-200">
                        <a href="/#">
                            <p>{content.content4}</p>
                        </a>
					</div>

                    <div class="lex items-center mb-2 pb-2 text-sm space-x-12 md:space-x-24 justify-between border-b border-gray-200">	
                        <a href="/#">
                            <p>{content.content5}</p>
                        </a> 
					</div>

                    <div class="lex items-center mb-2 pb-2 text-sm space-x-12 md:space-x-24 justify-between border-b border-gray-200">	
                        <a href="/#">
                            <p>{content.content6}</p>
                        </a>
					</div>

                    <div class="lex items-center mb-2 pb-2 text-sm space-x-12 md:space-x-24 justify-between border-b border-gray-200">
                        <a href="/#">
                            <p>{content.content7}</p>
                        </a>	
					</div>
				</div>  
			</div>
		</div>
         {/each}
	</div>
</main>
