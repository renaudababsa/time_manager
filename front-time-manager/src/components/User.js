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

export async function getUser(id) {
    let result;
    await api('/api/users/' + id.toString(), 'GET').then((res) => {
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