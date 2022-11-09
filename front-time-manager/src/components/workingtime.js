import { api } from '../services/api.js';

export async function createWorkingTime(start, end, userId) {
  let result;

  await api(`/api/workingtimes/${userId}`, 'POST', {
    working_time: {
      start: start,
      end: end,
    },
  }).then((res) => {
    result = res;
  });

  return result;
}

export async function updateWorkingTime(start, end, userId, id) {
  let result;
  api(`/api/workingtimes/${userId}/${id}`, 'PUT', {
    working_time: {
      start: start,
      end: end,
    },
  }).then((res) => {
    result = res;
  });
  return result;
}

export async function deleteWorkingTime(userId, id) {
  let result;
  api(`/api/workingtimes/${userId}/${id}`, 'DELETE').then((res) => {
    result = res;
  });
  return result;
}

export async function getUsername(id) {
  let result;
  await api(
    `/api/users/${id}`,
    'GET'
  ).then((res) => {
    result = res['data'];
  });
  return result.username;
}

export async function getId(username) {
  let result;
  await api(
    `/api/users/?username=${username}`,
    'GET'
  ).then((res) => {
    result = res['data'];
  });
  return result[0].id;
}

export async function getWorkingTime(userId, start_date, end_date) {
  let result;
  await api(
    `/api/workingtimes/${userId}?start=${start_date}&end=${end_date}`,
    'GET'
  ).then((res) => {
    result = res['data'];
  });
  return result;
}