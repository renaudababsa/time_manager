import { api } from '../services/api';

export async function getClocks(id) {
  let result;
  await api('/api/clocks/' + id, 'GET').then((res) => {
      result = res;
    });
  return result;
}
