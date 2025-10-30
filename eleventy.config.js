/**
 * Minimal Eleventy configuration to render our docs folder without Liquid parsing conflicts.
 */
export default function eleventyConfigFunction(eleventyConfig) {
  // Treat Markdown and HTML as plain content so Liquid doesn't try to parse {{PLACEHOLDERS}}.
  eleventyConfig.setMarkdownTemplateEngine(false);
  eleventyConfig.setHtmlTemplateEngine(false);

  // Allow Eleventy to merge nested data files if we add them later.
  eleventyConfig.setDataDeepMerge(true);

  return {
    dir: {
      input: "docs",
      includes: "_includes",
      data: "_data",
      output: "_site-eleventy",
    },
    templateFormats: ["md", "njk", "html"],
    markdownTemplateEngine: false,
    htmlTemplateEngine: false,
  };
}
