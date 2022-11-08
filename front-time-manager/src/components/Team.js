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

export async function createTeam(name) {
  let result;
  await api('/api/teams', 'POST', {
         teams: {
           name: name
         },
       }).then((res) => {
          result = res;
       });
  return result;
}

export async function deleteTeam(id) {
  let result;
  await api('/api/teams/' + id, 'DELETE').then((res) => {
      result = res;
    });
  return result;
}

export async function updateTeam(id, name) {
  let result;
  await api('/api/teams/' + id.toString(), 'PUT', {
      teams: {
        name:  name
      },
    }).then((res) => {
      result = res;
    });
  return result;
}