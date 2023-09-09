function parseJwt (token) {
    var base64Url = token.split('.')[1];
    var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
    var jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
    }).join(''));

    return JSON.parse(jsonPayload);
}

console.log(parseJwt('eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJmNWY2MDljOC1lZDNiLTQ2NTktYjljNy1hMGU3MTNhN2FjMTkiLCJ0b2tlbl91dWlkIjoiOTAyOWM4ZWYtNTNmYi00YWUwLWIzZTgtYjNmYWI4OWU1NWNlIiwiZXhwIjoxNjk0MjIyMzA2LCJpYXQiOjE2OTQyMjE0MDYsIm5iZiI6MTY5NDIyMTQwNn0.h5Cdy9JDXEcGBxPcBtVJrP6phpwEm72ogRlNFlsHIHpQfBBqMnTsexdOIJF0SzaoECEXst3pPUIL_mj9BkSckdeQxrKcAwE-YSQUDYZbV49TjLbHoNRjXoIHKUW31Vi8YYLZi21U-rEKS3ErnCIPwrEgsbHqgCU85u__pG1RYzKHP4oilCiTESAButSK2a0x5Q94wYnDMOK12CkIWWCBq6kx8jqGssfpLpfNfVfp3o0WFmXmiUM_YrlDfdzD0LMP1Aep8Oj1sPQfluM3LJKs9trdt4GdraHmZxFhVoz83nMaWPSlRgJF0byRcq0TR3fN0J3i4eTd2j3cDs17WgVqWTt3vZhvAp4NsHa7vj6o65OPyg2TtAwi6n6hprQONMh8VMg619s7NjmMRodW0X4wfEoPKQbNfUImN-6HYaZEalYkACUo1drV69EZsT1yHn8XRE2DJa6OsCIgu74HnRoo_2AysQZps5wDPw9rxQhQIJqJr91m82PpskB06mVVwyLsSgfMplRf4cQkgE7-lpm4sdaq9yRPLo3EpOxAZEpftZ6B82dCvdnJl-UrMkBe6QmhScXoAyJib0WqDS2AMovLxuEQmzHrtfrlIp31B5Ic_dV0kxj8gjvDIzPlo7f3_lAGlD2Qen2Z-mJ7VGLkmnMNASw_hp8FciWmSuEZ8o9vRoQ').token_uuid)
