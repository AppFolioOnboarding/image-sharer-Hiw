/* eslint-env mocha */

import assert from 'assert';
import { mount } from 'enzyme';
import React from 'react';
import Footer from '../../components/Footer';

describe('<Footer />', () => {
  it('should render correctly', () => {
    const wrapper = mount(<Footer text="foobar" />);
    const text = wrapper.find('footer');

    assert.strictEqual(text.length, 1);
    assert.strictEqual(text.text(), 'foobar');
  });
});
