const config = {
  api: 'http://localhost:3000',
};

const httpGet = async (endpoint) => {
  return await fetch(`${config.api}${endpoint}`, {
    method: "GET"
  })
    .then((response) => handleResponse(response))
    .then((response) => response)
    .catch((error) => {
      console.error(error);
      throw Error(error);
    });
};

const handleResponse = (response) => {
  switch (response.status) {
    case 302:
      return response.json();
    case 404:
      return null;
    default:
      throw Error(response.json() | 'error');
  }
};

export default { httpGet };
