/**
 * Minimal Eleventy configuration to render our docs folder without Liquid parsing conflicts.
 */
module.exports = function eleventyConfigFunction(eleventyConfig) {
	// Treat Markdown and HTML as plain content so Liquid doesn't try to parse {{PLACEHOLDERS}}.
	// (Configured in the return object below for Eleventy v3+)

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
};
