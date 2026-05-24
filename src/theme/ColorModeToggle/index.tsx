import React from 'react';
import ColorModeToggle from '@theme-original/ColorModeToggle';
import type ColorModeToggleType from '@theme/ColorModeToggle';
import type {WrapperProps} from '@docusaurus/types';

type Props = WrapperProps<typeof ColorModeToggleType>;

export default function ColorModeToggleWrapper(props: Props): JSX.Element {
  return (
    <div
      style={{
        '--d': 'inline-flex',
        '--radius': '50%',
        '--levitate-hvr': '20',
      } as React.CSSProperties}
    >
      <ColorModeToggle {...props} />
    </div>
  );
}
