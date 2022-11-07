import { api } from '../services/api';

export async function getGroups() {
    let result;
    await api('/api/groups/', 'GET').then((res) => {
        result = res;
      });
    return result;
}
