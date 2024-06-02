export const prune = (obj: any) => {
  if (!obj) return {};

  const result = { ...obj };
  Object.keys(result).forEach(
    (key) =>
      (result[key] === undefined || result[key] === null) && delete result[key],
  );
  return result;
};
