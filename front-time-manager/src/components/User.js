import { api } from '../services/api';

export async function createUser(username, password, email) {
    let result;
    await api('/api/users', 'POST', {
           user: {
             username:  username,
             group_id: "1",
             password: password,
             email: email,
           },
         }).then((res) => {
            result = res;
         });
    return result;
}

export function logoutUser() {
  localStorage.setItem('token', null)
}

export async function loginUser(email, password) {
  let result;
  await api('/api/users/login?email=' + email + '&password=' + password, 'POST').then((res) => {
      result = res;
    });
  return result;
}

export async function updateUser(id, username, email) {
    let result;
    await api('/api/users/' + id.toString(), 'PUT', {
        user: {
          username:  username,
          email: email,
        },
      }).then((res) => {
        result = res;
      });
    return result;
}

export async function updateUserRole(id, group_id) {
  let result;
  await api('/api/users/' + id.toString(), 'PATCH', {
      user: {
        group_id:  group_id
      },
    }).then((res) => {
      result = res;
    });
  return result;
}

export async function updateUserTeam(id, team_id) {
  let result;
  await api('/api/users/' + id.toString(), 'PATCH', {
      user: {
        team_id:  team_id
      },
    }).then((res) => {
      result = res;
    });
  return result;
}

export async function getUser(id) {
    let result;
    await api('/api/users/' + id.toString(), 'GET').then((res) => {
           return (res);
         }).then((res) => {
            result = res;
         });
    return result;
}

export async function getUsers() {
  let result;
  await api('/api/users/', 'GET').then((res) => {
         return (res);
       }).then((res) => {
          result = res;
       });
  return result;
}

export async function getUsersByTeam(id) {
  let result;
  await api('/api/users/teams/' + id, 'GET').then((res) => {
         return (res);
       }).then((res) => {
          result = res;
       });
  return result;
}

export async function deleteUser(id) {
    let result;
    await api('/api/users/' + id.toString(), 'DELETE').then((res) => {
        result = res;
      });
    return result;
}