import { api } from '../services/api';

export async function getTeams() {
    let result;
    await api('/api/teams/', 'GET').then((res) => {
        result = res;
      });
    return result;
}

export async function getTeam(id) {
  let result;
  await api('/api/teams/' + id, 'GET').then((res) => {
      result = res;
    });
  return result;
}
