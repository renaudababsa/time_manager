// import { useSession } from '../stores/session.js';

export const BASE_URL = 'http://127.0.0.1:4000';

export async function api(url) {
  //   const session = useSession();

  let params = Object.assign({
    mode: 'cors',
    cache: 'no-cache',
    method: 'GET',
  });

  //   params.headers = Object.assign(
  //     {
  //       //   Authorization: `Bearer ${session.token}`,
  //       'Content-Type': 'application/json',
  //     },
  //     params.headers
  //   );

  let response = await fetch(BASE_URL + url, params);
  let json = (await response.json()) || {};
  if (!response.ok) {
    let errorMessage = json.error || response.status;
    throw new Error(errorMessage);
  }
  return json;
}
