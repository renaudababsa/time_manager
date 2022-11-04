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
          'token': localStorage.getItem("token"),
        },
        body: JSON.stringify(content),
      })
    : Object.assign({
        mode: 'cors',
        cache: 'no-cache',
        method: method,
      });

  let response = await fetch(BASE_URL + url, params);
  let json = (await response.json()) || {};
  if (!response.ok) {
    let errorMessage = json.error || response.status;
    throw new Error(errorMessage);
  }
  return json;
}
