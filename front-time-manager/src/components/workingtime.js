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

export async function getWorkingTime(userId) {
  let result;
  api(
    '/api/workingtimes/1?start=2022-10-06 11:15:11&end=2023-10-06 11:11:11',
    'GET'
  ).then((res) => {
    result = res['data'];
  });
  return result;
}
