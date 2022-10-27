import { api } from '../services/api';
export async function refresh(bool) {
  await api(`/api/clocks/${userId}`, 'PUT', { status: bool }).then((res) => {
    console.log(res);
  });
}

export async function clock(userId) {
  let result;
  await api(`/api/clocks/${userId}`, 'GET').then((res) => {
    result = res;
  });
  return result;
}
