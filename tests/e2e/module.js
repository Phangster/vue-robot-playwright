async function myGoToKeyword(pageUrl, page) {
  await page.goto(pageUrl);
  return page.title();
}
// eslint-disable-next-line no-underscore-dangle
exports.__esModule = true;
exports.myGoToKeyword = myGoToKeyword;
