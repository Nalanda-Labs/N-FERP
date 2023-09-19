<script>
  import { Input, Label, Button, Select, Radio, Checkbox } from 'flowbite-svelte';
  import {enhance} from "$app/forms"  
  let selected;
  let roles = [
    { value: 'admin', name: 'Administrator' },
    { value: 'Technology', name: 'Tech' },
  ];
</script>

CREATE USER 


<form  action="?/create" use:enhance method= "POST" >
  <div class="grid gap-6 mb-6 md:grid-cols-2 mt-20">
    <div>
      <Label for="first_name" class="mb-2">First name</Label>
      <Input name="first_name" type="text" id="first_name" placeholder="John"  required />
    </div>
    <div>
      <Label for="last_name" class="mb-2">Last name</Label>
      <Input name="last_name" type="text" id="last_name" placeholder="Doe" required />
    </div>
    <div>
      <Label for="company" class="mb-2">Department</Label>
      <Input type="text" id="company" placeholder="Flowbite"/>
    </div>
    <div>
      <Label for="phone" class="mb-2">Phone</Label>
     <Input type="tel" id="phone" placeholder="+91" pattern={"[0-9]{10}"}/>
    </div>
    <div class="mb-6">
      <Label for="email" class="mb-2">Email</Label>
      <Input type="email" id="email" name="email" placeholder="name@flowbite.com" />
    </div>
    <div class="mb-6">
      <Label for="user" class="mb-2">Username</Label>
      <Input name=""user type="text" id="user" placeholder="john231" required />
    </div>
    <div class="mb-6">
      <Label for="password" class="mb-2">password</Label>
      <Input type="password" id="password" placeholder="•••••••••" required />
    </div>
    <div class="mb-6">
      <p class="mb-4 text-gray-900 dark:text-white">System administrator</p>
      <ul class="items-center w-full rounded-lg border border-gray-200 sm:flex dark:bg-gray-800 dark:border-gray-600 divide-x divide-gray-200 dark:divide-gray-600">
        <li class="w-full"><Checkbox class="p-3">Yes</Checkbox></li>
        <li class="w-full"><Checkbox class="p-3">No</Checkbox></li>
      </ul>
    </div>
    <div class="mb-6">
      <Label>
      Role
      <Select class="mt-2" items={roles} bind:value={selected} />
      </Label>
    </div>

    <div class="mb-6">
      <p class="mb-4 text-gray-900 dark:text-white">Status</p>
      <ul class="items-center w-full rounded-lg border border-gray-200 sm:flex dark:bg-gray-800 dark:border-gray-600 divide-x divide-gray-200 dark:divide-gray-600">
        <li class="w-full"><Radio name="hor-list" class="p-3">Active</Radio></li>
        <li class="w-full"><Radio name="hor-list" class="p-3">Inactive</Radio></li>
      </ul>
      
    </div>

  </div>
  <Button type="submit">Create</Button>
</form>