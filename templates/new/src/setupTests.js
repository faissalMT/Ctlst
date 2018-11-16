import { configure } from 'enzyme';
import { watchFile } from "fs";
import Adapter from 'enzyme-adapter-react-16';

configure({ adapter: new Adapter() });
