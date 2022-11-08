// import { useSession } from '../stores/session.js';

export const BASE_URL = 'http://127.0.0.1:4000';

export async function api(url, method, content = false) {
  //   const session = useSession();

  let params = content
    ? Object.assign({
        cache: 'no-cache',
        method: method,
        headers: {
          'content-type': 'application/json',
          //add access control origin
          "x-csrf-token": localStorage.getItem('token')
          //   Authorization: `Bearer ${session.token}`,
        },
        body: JSON.stringify(content),
      })
    : Object.assign({
        mode: 'cors',
        cache: 'no-cache',
        method: method,
        headers: {  
          "x-csrf-token": localStorage.getItem('token')
        },
      });

  let response = await fetch(BASE_URL + url, params);
  let json = (await response.json()) || {};
  if (!response.ok) {
    if (response.status == 401) {
      localStorage.removeItem("id");
      localStorage.removeItem("username");
      localStorage.removeItem("token");
      localStorage.removeItem("level")
      location.reload();
    }
    let errorMessage = json.error || response.status;
    throw new Error(errorMessage);
  }
  return json;
}
