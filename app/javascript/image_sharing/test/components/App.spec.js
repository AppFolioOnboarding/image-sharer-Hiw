/* eslint-env mocha */

import assert from 'assert';
import { shallow } from 'enzyme';
import React from 'react';
import App from '../../components/App';

describe('<App />', () => {
  it('should render correctly', () => {
    const wrapper = shallow(<App />);

    assert.strictEqual(wrapper.find('Header').length, 1);
    assert.strictEqual(wrapper.find('Header').prop('title'), 'Tell us what you think');
    assert.strictEqual(wrapper.find('Button').length, 1);
    assert.strictEqual(wrapper.find('#nameForm').length, 1);
    assert.strictEqual(wrapper.find('#commentsForm').length, 1);
    assert.strictEqual(wrapper.find('Footer').length, 1);
    assert.strictEqual(wrapper.find('Footer').prop('text'), 'Copyright: Appfolio Inc. Onboarding');
  });

  it('should be able to populate name', () => {
    const wrapper = shallow(<App />);
    const name = 'Foo Bar';

    wrapper.setState({ name });
    const nameForm = wrapper.find('#nameForm');

    assert.strictEqual(nameForm.prop('value'), name);
  });

  it('should be able to set name state', () => {
    const wrapper = shallow(<App />);
    const name = 'Foo Bar';
    const event = { target: { value: name } };

    const nameForm = wrapper.find('#nameForm');
    nameForm.simulate('change', event);

    assert.strictEqual(wrapper.state('name'), name);
  });

  it('should be able to populate comments', () => {
    const wrapper = shallow(<App />);
    const comments = 'Foo Bar\nThis is a comment!';

    wrapper.setState({ comments });
    const commentsForm = wrapper.find('#commentsForm');

    assert.strictEqual(commentsForm.prop('value'), comments);
  });

  it('should be able to set comments state', () => {
    const wrapper = shallow(<App />);
    const comments = 'Foo Bar\nThis is a comment!';
    const event = { target: { value: comments } };

    const commentsForm = wrapper.find('#commentsForm');
    commentsForm.simulate('change', event);

    assert.strictEqual(wrapper.state('comments'), comments);
  });
});
