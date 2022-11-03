import ApiService from './ApiService.js';

export async function getBestFit(length, width, height, weight) {
  try{
    return await ApiService.httpGet(`/api/v1/products/${length}/${width}/${height}/${weight}`)
  }catch(error) {
    throw Error(error);
  }
}

export default { getBestFit };
