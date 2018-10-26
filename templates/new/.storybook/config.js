import { configure } from '@storybook/react'

function loadStories () {
  const requireStories = require.context('../src/Component', true, /stories\.js$/)
  const children = requireStories.keys()

  children.forEach(requireStories)
}

configure(loadStories, module)
