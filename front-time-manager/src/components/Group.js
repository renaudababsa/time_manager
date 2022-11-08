import { api } from '../services/api';

export async function getGroups() {
    let result;
    await api('/api/groups/', 'GET').then((res) => {
        result = res;
      });
    return result;
}

export async function getGroup(id) {
  let result;
  await api('/api/groups/' + id, 'GET').then((res) => {
      result = res;
    });
  return result;
}
