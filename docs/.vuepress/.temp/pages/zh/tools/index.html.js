import comp from "/Users/yc/github/YCBlogBook/docs/.vuepress/.temp/pages/zh/tools/index.html.vue"
const data = JSON.parse("{\"path\":\"/zh/tools/\",\"title\":\"Tools\",\"lang\":\"en-US\",\"frontmatter\":{\"title\":\"Tools\"},\"headers\":[],\"filePathRelative\":null}")
export { comp, data }

if (import.meta.webpackHot) {
  import.meta.webpackHot.accept()
  if (__VUE_HMR_RUNTIME__.updatePageData) {
    __VUE_HMR_RUNTIME__.updatePageData(data)
  }
}

if (import.meta.hot) {
  import.meta.hot.accept(({ data }) => {
    __VUE_HMR_RUNTIME__.updatePageData(data)
  })
}
